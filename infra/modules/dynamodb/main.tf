# ==============================================================================
# Architectural Overview: Destination Voting Platform Storage
# ==============================================================================
# This module provisions the central DynamoDB table for user votes.
#
# Access Pattern Design:
# 1. Individual Vote Management (CRUD):
#    - PK: 'userId' (String)
#    - Allows direct GetItem, PutItem (upsert), and DeleteItem operations 
#      by userId, enforcing the one-user-one-vote business constraint.
#
# 2. Result Aggregation:
#    - GSI: 'destination-index' (PK: 'destination')
#    - Facilitates efficient aggregation of all votes cast for a specific
#      destination without requiring costly full table scans.
# ==============================================================================

resource "aws_dynamodb_table" "votes" {
  name         = "svp-${var.environment}-votes"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"

  # Primary Schema Attributes
  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "destination"
    type = "S"
  }

  # Point-in-Time Recovery enabled for maximum data durability
  point_in_time_recovery {
    enabled = true
  }

  # Server-side encryption enabled using default AWS managed key
  server_side_encryption {
    enabled = true
  }

  # Global Secondary Index for destination-based result aggregation
  global_secondary_index {
    name            = "destination-index"
    hash_key        = "destination"
    projection_type = "ALL"
  }

  # Data protection: prevent accidental table destruction
  lifecycle {
    prevent_destroy = true
  }

  # Merge provided tags with a default name tag
  tags = merge(
    {
      Name = "svp-${var.environment}-votes"
    },
    var.tags
  )
}
