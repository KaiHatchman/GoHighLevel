import { ghlClient, LOCATION_ID } from './client';

export async function getContact(contactId: string) {
  const { data } = await ghlClient.get(`/contacts/${contactId}`);
  return data.contact;
}

export async function createContact(payload: {
  firstName?: string;
  lastName?: string;
  email?: string;
  phone?: string;
  [key: string]: any;
}) {
  const { data } = await ghlClient.post('/contacts/', {
    locationId: LOCATION_ID,
    ...payload,
  });
  return data.contact;
}

export async function updateContact(contactId: string, payload: Record<string, any>) {
  const { data } = await ghlClient.put(`/contacts/${contactId}`, payload);
  return data.contact;
}

export async function addTags(contactId: string, tags: string[]) {
  const { data } = await ghlClient.post(`/contacts/${contactId}/tags`, { tags });
  return data;
}

export async function removeTags(contactId: string, tags: string[]) {
  const { data } = await ghlClient.delete(`/contacts/${contactId}/tags`, { data: { tags } });
  return data;
}
