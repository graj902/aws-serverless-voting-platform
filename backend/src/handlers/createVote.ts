import { APIGatewayProxyEventV2, APIGatewayProxyResultV2 } from 'aws-lambda';
import { putVote } from '../services/dynamodbService';

export const createVote = async (event: APIGatewayProxyEventV2): Promise<APIGatewayProxyResultV2> => {
  try {
    const userId = (event.requestContext as any).authorizer?.jwt?.claims?.sub as string;
    if (!userId) return { statusCode: 401, body: JSON.stringify({ message: 'Unauthorized' }) };

    const { destination } = JSON.parse(event.body || '{}');
    if (!destination) return { statusCode: 400, body: JSON.stringify({ message: 'Destination is required' }) };

    await putVote({ userId, destination, timestamp: Date.now() });

    return { statusCode: 201, body: JSON.stringify({ message: 'Vote created' }) };
  } catch (error) {
    console.error('Error in createVote:', error);
    return { statusCode: 500, body: JSON.stringify({ message: 'Internal Server Error' }) };
  }
};
