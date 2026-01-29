import * as fs from 'fs';
import * as path from 'path';

export interface ProjectConfig {
  name: string;
  type: 'DeFi' | 'NFT' | 'GameFi' | 'DAO' | 'Infrastructure' | 'Custom';
  phase: 'planning' | 'architecture' | 'development' | 'testing' | 'deployment' | 'complete';
}

export interface AgentStatus {
  status: 'idle' | 'working' | 'waiting' | 'error' | 'complete';
  current_task: string | null;
  last_update: string;
  progress: number;
}

export interface GlobalState {
  project: ProjectConfig & {
    started_at: string;
    updated_at: string;
  };
  agents: Record<string, AgentStatus>;
  dependencies: {
    package_ids: {
      devnet?: string;
      testnet?: string;
      mainnet?: string;
    };
    integrations: string[];
  };
  artifacts: {
    specs: string[];
    contracts: string[];
    tests: string[];
    deployed_packages: string[];
  };
}

export class StateManager {
  private state: GlobalState | null = null;
  private stateFilePath: string;

  constructor(stateFilePath: string = '.claude/sui-agent-state.json') {
    this.stateFilePath = stateFilePath;
    this.load();
  }

  initialize(config: ProjectConfig): GlobalState {
    const now = new Date().toISOString();
    this.state = {
      project: {
        ...config,
        started_at: now,
        updated_at: now
      },
      agents: {},
      dependencies: {
        package_ids: {},
        integrations: []
      },
      artifacts: {
        specs: [],
        contracts: [],
        tests: [],
        deployed_packages: []
      }
    };
    this.save();
    return this.state;
  }

  getState(): GlobalState {
    if (!this.state) {
      throw new Error('State not initialized. Call initialize() first.');
    }
    return this.state;
  }

  updateAgent(agentId: string, status: Partial<AgentStatus>): void {
    if (!this.state) {
      throw new Error('State not initialized');
    }

    const existing = this.state.agents[agentId] || {
      status: 'idle',
      current_task: null,
      last_update: new Date().toISOString(),
      progress: 0
    };

    this.state.agents[agentId] = {
      ...existing,
      ...status,
      last_update: new Date().toISOString()
    };

    this.state.project.updated_at = new Date().toISOString();
    this.save();
  }

  updatePhase(phase: GlobalState['project']['phase']): void {
    if (!this.state) {
      throw new Error('State not initialized');
    }

    this.state.project.phase = phase;
    this.state.project.updated_at = new Date().toISOString();
    this.save();
  }

  addArtifact(type: keyof GlobalState['artifacts'], path: string): void {
    if (!this.state) {
      throw new Error('State not initialized');
    }

    if (!this.state.artifacts[type].includes(path)) {
      this.state.artifacts[type].push(path);
    }

    this.save();
  }

  addIntegration(integration: string): void {
    if (!this.state) {
      throw new Error('State not initialized');
    }

    if (!this.state.dependencies.integrations.includes(integration)) {
      this.state.dependencies.integrations.push(integration);
    }

    this.save();
  }

  setPackageId(network: 'devnet' | 'testnet' | 'mainnet', packageId: string): void {
    if (!this.state) {
      throw new Error('State not initialized');
    }

    this.state.dependencies.package_ids[network] = packageId;
    this.save();
  }

  save(): void {
    if (!this.state) {
      return;
    }

    const dir = path.dirname(this.stateFilePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }

    fs.writeFileSync(this.stateFilePath, JSON.stringify(this.state, null, 2));
  }

  private load(): void {
    if (fs.existsSync(this.stateFilePath)) {
      const content = fs.readFileSync(this.stateFilePath, 'utf-8');
      this.state = JSON.parse(content);
    }
  }
}
