import boto3
import json
from datetime import datetime

def lambda_handler(event, context):
    # Initialize the DynamoDB client
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('Files')

    # Get the file name from S3 event
    file_name = event['Records'][0]['s3']['object']['key']

    # Save to DynamoDB
    table.put_item(
        Item={
            'FileName': file_name,
            'UploadTime': datetime.now().isoformat()
        }
    )

    print(f"File saved: {file_name}")
    return {
        'statusCode': 200,
        'body': json.dumps(f'Successfully processed {file_name}')
    }
