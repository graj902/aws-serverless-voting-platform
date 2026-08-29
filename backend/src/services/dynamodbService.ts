import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, GetCommand, PutCommand, DeleteCommand, QueryCommand, UpdateCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);
const TableName = process.env.TABLE_NAME || '';

export const getVote = async (userId: string) => {
  return docClient.send(new GetCommand({ TableName, Key: { userId } }));
};

export const putVote = async (vote: any) => {
  return docClient.send(new PutCommand({ TableName, Item: vote }));
};

export const updateVote = async (userId: string, destination: string) => {
  return docClient.send(
    new UpdateCommand({
      TableName,
      Key: { userId },
      UpdateExpression: "SET destination = :dest, #ts = :ts",
      ExpressionAttributeNames: { "#ts": "timestamp" },
      ExpressionAttributeValues: { ":dest": destination, ":ts": Date.now() },
    })
  );
};

export const deleteVote = async (userId: string) => {
  return docClient.send(new DeleteCommand({ TableName, Key: { userId } }));
};

export const queryVotesByDestination = async (destination: string) => {
  return docClient.send(
    new QueryCommand({
      TableName,
      IndexName: process.env.GSI_NAME,
      KeyConditionExpression: "destination = :dest",
      ExpressionAttributeValues: { ":dest": destination },
    })
  );
};
