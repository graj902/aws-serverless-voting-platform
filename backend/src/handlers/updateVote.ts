import { APIGatewayProxyEventV2, APIGatewayProxyResultV2 } from 'aws-lambda';
import { updateVote as updateVoteService, getVote } from '../services/dynamodbService';

export const updateVote = async (event: APIGatewayProxyEventV2): Promise<APIGatewayProxyResultV2> => {
  try {
    const userId = (event.requestContext as any).authorizer?.jwt?.claims?.sub as string;
    if (!userId) return { statusCode: 401, body: JSON.stringify({ message: 'Unauthorized' }) };

    const { destination } = JSON.parse(event.body || '{}');
    if (!destination) return { statusCode: 400, body: JSON.stringify({ message: 'Destination is required' }) };

    const existing = await getVote(userId);
    if (!existing.Item) return { statusCode: 404, body: JSON.stringify({ message: 'Vote not found' }) };

    await updateVoteService(userId, destination);

    return { statusCode: 200, body: JSON.stringify({ message: 'Vote updated' }) };
  } catch (error) {
    console.error('Error in updateVote:', error);
    return { statusCode: 500, body: JSON.stringify({ message: 'Internal Server Error' }) };
  }
};
