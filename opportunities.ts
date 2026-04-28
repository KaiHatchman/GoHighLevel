import { ghlClient, LOCATION_ID } from './client';

export async function searchOpportunity(query: string) {
  const { data } = await ghlClient.get('/opportunities/search', {
    params: { location_id: LOCATION_ID, query },
  });
  return data.opportunities;
}

export async function updateOpportunity(
  opportunityId: string,
  payload: {
    status?: string;
    stageId?: string;
    monetaryValue?: number;
    [key: string]: any;
  }
) {
  const { data } = await ghlClient.put(`/opportunities/${opportunityId}`, payload);
  return data.opportunity;
}
