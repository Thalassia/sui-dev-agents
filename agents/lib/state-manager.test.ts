import { describe, it, expect, beforeEach } from 'vitest';
import { StateManager } from './state-manager';
import * as fs from 'fs';
import * as path from 'path';

describe('StateManager', () => {
  const testStateFile = '.claude/test-agent-state.json';
  let stateManager: StateManager;

  beforeEach(() => {
    // Clean up test state file
    if (fs.existsSync(testStateFile)) {
      fs.unlinkSync(testStateFile);
    }
    stateManager = new StateManager(testStateFile);
  });

  it('should initialize new state', () => {
    const state = stateManager.initialize({
      name: 'test-project',
      type: 'NFT',
      phase: 'planning'
    });

    expect(state.project.name).toBe('test-project');
    expect(state.project.type).toBe('NFT');
    expect(state.project.phase).toBe('planning');
    expect(state.agents).toEqual({});
  });

  it('should update agent status', () => {
    stateManager.initialize({ name: 'test', type: 'NFT', phase: 'planning' });

    stateManager.updateAgent('sui-development-agent', {
      status: 'working',
      current_task: 'Generate Move code',
      progress: 0.5
    });

    const state = stateManager.getState();
    expect(state.agents['sui-development-agent'].status).toBe('working');
    expect(state.agents['sui-development-agent'].progress).toBe(0.5);
  });

  it('should update project phase', () => {
    stateManager.initialize({ name: 'test', type: 'NFT', phase: 'planning' });

    stateManager.updatePhase('development');

    const state = stateManager.getState();
    expect(state.project.phase).toBe('development');
  });

  it('should add artifacts', () => {
    stateManager.initialize({ name: 'test', type: 'NFT', phase: 'planning' });

    stateManager.addArtifact('specs', 'docs/specs/marketplace-spec.md');
    stateManager.addArtifact('contracts', 'contracts/listing.move');

    const state = stateManager.getState();
    expect(state.artifacts.specs).toContain('docs/specs/marketplace-spec.md');
    expect(state.artifacts.contracts).toContain('contracts/listing.move');
  });

  it('should persist state to file', () => {
    stateManager.initialize({ name: 'test', type: 'NFT', phase: 'planning' });
    stateManager.save();

    expect(fs.existsSync(testStateFile)).toBe(true);

    const loaded = JSON.parse(fs.readFileSync(testStateFile, 'utf-8'));
    expect(loaded.project.name).toBe('test');
  });

  it('should load existing state', () => {
    const initialState = {
      project: { name: 'existing', type: 'DeFi', phase: 'development' },
      agents: {},
      dependencies: { package_ids: {}, integrations: [] },
      artifacts: { specs: [], contracts: [], tests: [], deployed_packages: [] }
    };

    fs.mkdirSync(path.dirname(testStateFile), { recursive: true });
    fs.writeFileSync(testStateFile, JSON.stringify(initialState, null, 2));

    const loadedManager = new StateManager(testStateFile);
    const state = loadedManager.getState();

    expect(state.project.name).toBe('existing');
    expect(state.project.type).toBe('DeFi');
  });
});
