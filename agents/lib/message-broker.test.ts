import { describe, it, expect, beforeEach } from 'vitest';
import { MessageBroker, Message } from './message-broker';

describe('MessageBroker', () => {
  let broker: MessageBroker;

  beforeEach(() => {
    broker = new MessageBroker();
  });

  it('should send and receive messages', async () => {
    const message: Message = {
      type: 'task_assignment',
      from: 'sui-supreme',
      to: 'sui-development-agent',
      payload: {
        task: 'Generate Move code'
      },
      timestamp: new Date().toISOString()
    };

    broker.send(message);

    const received = await broker.receive('sui-development-agent');
    expect(received).toHaveLength(1);
    expect(received[0].payload.task).toBe('Generate Move code');
  });

  it('should filter messages by recipient', async () => {
    broker.send({
      type: 'task_assignment',
      from: 'sui-supreme',
      to: 'sui-development-agent',
      payload: { task: 'Task 1' },
      timestamp: new Date().toISOString()
    });

    broker.send({
      type: 'task_assignment',
      from: 'sui-supreme',
      to: 'sui-ecosystem-agent',
      payload: { task: 'Task 2' },
      timestamp: new Date().toISOString()
    });

    const devMessages = await broker.receive('sui-development-agent');
    expect(devMessages).toHaveLength(1);
    expect(devMessages[0].payload.task).toBe('Task 1');
  });

  it('should support broadcast messages', async () => {
    broker.send({
      type: 'state_update',
      from: 'sui-tester-subagent',
      to: 'broadcast',
      payload: { test_results: { passed: 10, failed: 0 } },
      timestamp: new Date().toISOString()
    });

    const devMessages = await broker.receive('sui-development-agent');
    const coreMessages = await broker.receive('sui-core-agent');

    expect(devMessages[0].payload.test_results.passed).toBe(10);
    expect(coreMessages[0].payload.test_results.passed).toBe(10);
  });

  it('should acknowledge message receipt', async () => {
    const message: Message = {
      id: 'msg-123',
      type: 'service_request',
      from: 'sui-developer-subagent',
      to: 'sui-docs-query-subagent',
      payload: { query: 'Latest API' },
      timestamp: new Date().toISOString()
    };

    broker.send(message);

    const received = await broker.receive('sui-docs-query-subagent');
    broker.acknowledge(received[0].id!);

    const pending = await broker.receive('sui-docs-query-subagent');
    expect(pending).toHaveLength(0);
  });

  it('should reply to messages', async () => {
    const request: Message = {
      id: 'req-1',
      type: 'service_request',
      from: 'sui-developer-subagent',
      to: 'sui-docs-query-subagent',
      payload: { query: 'Kiosk API' },
      timestamp: new Date().toISOString()
    };

    broker.send(request);

    const response: Message = {
      type: 'service_response',
      from: 'sui-docs-query-subagent',
      to: 'sui-developer-subagent',
      payload: { result: 'Kiosk documentation...' },
      in_reply_to: 'req-1',
      timestamp: new Date().toISOString()
    };

    broker.send(response);

    const replies = await broker.receive('sui-developer-subagent');
    expect(replies[0].in_reply_to).toBe('req-1');
    expect(replies[0].payload.result).toContain('Kiosk');
  });
});
