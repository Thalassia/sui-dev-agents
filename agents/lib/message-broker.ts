import { EventEmitter } from 'events';

export type MessageType =
  | 'task_assignment'
  | 'service_request'
  | 'service_response'
  | 'progress_report'
  | 'state_update'
  | 'decision_request'
  | 'error_report';

export interface Message {
  id?: string;
  type: MessageType;
  from: string;
  to: string | 'broadcast';
  payload: any;
  timestamp: string;
  in_reply_to?: string;
}

export class MessageBroker extends EventEmitter {
  private messageQueue: Map<string, Message[]> = new Map();
  private acknowledgedMessages: Set<string> = new Set();

  send(message: Message): void {
    // Generate ID if not provided
    if (!message.id) {
      message.id = `msg-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
    }

    // Handle broadcast
    if (message.to === 'broadcast') {
      // Pre-register common agent types for broadcasts
      const commonAgents = [
        'sui-supreme',
        'sui-core-agent',
        'sui-infrastructure-agent',
        'sui-development-agent',
        'sui-ecosystem-agent'
      ];

      commonAgents.forEach(agent => {
        if (!this.messageQueue.has(agent)) {
          this.messageQueue.set(agent, []);
        }
      });

      // Broadcast to all registered recipients
      const recipients = Array.from(this.messageQueue.keys());
      recipients.forEach(recipient => {
        this.addToQueue(recipient, { ...message });
      });

      // Also emit event for any listeners
      this.emit('broadcast', message);
    } else {
      // Send to specific recipient
      this.addToQueue(message.to, message);
      this.emit('message', message);
    }
  }

  async receive(agentId: string): Promise<Message[]> {
    // Ensure agent has a queue
    if (!this.messageQueue.has(agentId)) {
      this.messageQueue.set(agentId, []);
    }

    // Return unacknowledged messages
    const queue = this.messageQueue.get(agentId)!;
    return queue.filter(msg => !this.acknowledgedMessages.has(msg.id!));
  }

  acknowledge(messageId: string): void {
    this.acknowledgedMessages.add(messageId);

    // Remove from all queues
    this.messageQueue.forEach((queue, agentId) => {
      const filtered = queue.filter(msg => msg.id !== messageId);
      this.messageQueue.set(agentId, filtered);
    });
  }

  reply(originalMessage: Message, response: Omit<Message, 'in_reply_to'>): void {
    this.send({
      ...response,
      in_reply_to: originalMessage.id
    });
  }

  private addToQueue(agentId: string, message: Message): void {
    if (!this.messageQueue.has(agentId)) {
      this.messageQueue.set(agentId, []);
    }
    this.messageQueue.get(agentId)!.push(message);
  }

  clearQueue(agentId: string): void {
    this.messageQueue.set(agentId, []);
  }

  getAllMessages(agentId: string): Message[] {
    return this.messageQueue.get(agentId) || [];
  }
}
