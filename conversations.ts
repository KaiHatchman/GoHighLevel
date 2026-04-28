import { ghlClient } from './client';

export async function getMessages(conversationId: string) {
  const { data } = await ghlClient.get(`/conversations/${conversationId}/messages`);
  return data.messages;
}

export async function sendMessage(conversationId: string, payload: {
  type: 'SMS' | 'Email' | 'WhatsApp';
  message: string;
}) {
  const { data } = await ghlClient.post('/conversations/messages', {
    conversationId,
    ...payload,
  });
  return data;
}
