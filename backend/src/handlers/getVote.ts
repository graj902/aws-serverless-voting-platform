import { APIGatewayProxyEventV2, APIGatewayProxyResultV2 } from 'aws-lambda';
import { getVote as getVoteService } from '../services/dynamodbService';

export const getVote = async (event: APIGatewayProxyEventV2): Promise<APIGatewayProxyResultV2> => {
  try {
    const userId = (event.requestContext as any).authorizer?.jwt?.claims?.sub as string;
    if (!userId) return { statusCode: 401, body: JSON.stringify({ message: 'Unauthorized' }) };

    const result = await getVoteService(userId);
    if (!result.Item) return { statusCode: 404, body: JSON.stringify({ message: 'Vote not found' }) };

    return { statusCode: 200, body: JSON.stringify(result.Item) };
  } catch (error) {
    console.error('Error in getVote:', error);
    return { statusCode: 500, body: JSON.stringify({ message: 'Internal Server Error' }) };
  }
};
