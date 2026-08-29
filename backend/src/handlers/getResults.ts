import { APIGatewayProxyEventV2, APIGatewayProxyResultV2 } from 'aws-lambda';
import { queryVotesByDestination } from '../services/dynamodbService';

export const getResults = async (event: APIGatewayProxyEventV2): Promise<APIGatewayProxyResultV2> => {
  try {
    const destination = event.queryStringParameters?.destination;
    if (!destination) {
      return { statusCode: 400, body: JSON.stringify({ message: 'Destination parameter is required' }) };
    }

    const result = await queryVotesByDestination(destination);

    return {
      statusCode: 200,
      body: JSON.stringify({
        count: result.Count || 0,
        votes: result.Items || [],
      }),
    };
  } catch (error) {
    console.error('Error in getResults:', error);
    return { statusCode: 500, body: JSON.stringify({ message: 'Internal Server Error' }) };
  }
};
