import { APIGatewayProxyEventV2, APIGatewayProxyResultV2 } from 'aws-lambda';
import { deleteVote as deleteVoteService, getVote } from '../services/dynamodbService';

export const deleteVote = async (event: APIGatewayProxyEventV2): Promise<APIGatewayProxyResultV2> => {
  try {
    const userId = (event.requestContext as any).authorizer?.jwt?.claims?.sub as string;
    if (!userId) return { statusCode: 401, body: JSON.stringify({ message: 'Unauthorized' }) };

    const existing = await getVote(userId);
    if (!existing.Item) return { statusCode: 404, body: JSON.stringify({ message: 'Vote not found' }) };

    await deleteVoteService(userId);

    return { statusCode: 200, body: JSON.stringify({ message: 'Vote deleted' }) };
  } catch (error) {
    console.error('Error in deleteVote:', error);
    return { statusCode: 500, body: JSON.stringify({ message: 'Internal Server Error' }) };
  }
};
