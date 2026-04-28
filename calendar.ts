import { ghlClient, LOCATION_ID } from './client';

export async function getCalendarEvents(params: {
  startTime: string;
  endTime: string;
  calendarId?: string;
}) {
  const { data } = await ghlClient.get('/calendars/events', {
    params: { locationId: LOCATION_ID, ...params },
  });
  return data.events;
}

export async function getAppointmentNotes(eventId: string) {
  const { data } = await ghlClient.get(`/calendars/events/appointments/${eventId}/notes`);
  return data.notes;
}
