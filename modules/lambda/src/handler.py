import boto3
import json
from datetime import datetime

# Initialize the DynamoDB client
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Files')

# Get the file name (you'll need to specify this)
file_name = event['Records'][0]['s3']['object']['key']

# Save to DynamoDB
table.put_item(
    Item={
        'FileName': file_name,
        'UploadTime': datetime.now().isoformat()
    }
)

print(f"File saved: {file_name}")
