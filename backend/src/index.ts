import { APIGatewayProxyEventV2, APIGatewayProxyResultV2 } from 'aws-lambda';
import { createVote } from './handlers/createVote';
import { getVote } from './handlers/getVote';
import { updateVote } from './handlers/updateVote';
import { deleteVote } from './handlers/deleteVote';
import { getResults } from './handlers/getResults';

export const handler = async (event: APIGatewayProxyEventV2): Promise<APIGatewayProxyResultV2> => {
  const method = event.requestContext.http.method;
  const path = event.requestContext.http.path;

  try {
    switch (`${method} ${path}`) {
      case 'POST /vote':
        return await createVote(event);
      case 'GET /vote':
        return await getVote(event);
      case 'PUT /vote':
        return await updateVote(event);
      case 'DELETE /vote':
        return await deleteVote(event);
      case 'GET /results':
        return await getResults(event);
      default:
        return {
          statusCode: 404,
          body: JSON.stringify({ message: 'Not Found' }),
        };
    }
  } catch (error) {
    console.error('Error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ message: 'Internal Server Error' }),
    };
  }
};
