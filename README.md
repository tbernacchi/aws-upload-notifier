# aws-upload-notifier

This project sets up an automated workflow where files uploaded to an S3 bucket trigger a Lambda function that records the file information in DynamoDB.

> The main purpose of this project was to practice a litte bit of architecture on AWS using terraform/terragrunt.

## Architecture

![Architecture](assignment.drawio.png)

We're going to track a list of files that have been uploaded. For this we're going to need:
- A S3 Bucket to where we upload files;
- A DynamoDb table called `Files` with an attribute `FileName`;
- A Stepfunction that writes to the DynamoDb table;
- A Lambda that get's triggered after a file upload and then executes the stepfunction.

### Prerequisites
- AWS CLI configured
- Terraform v1.9.8
- Terragrunt v0.69.1

# Usage

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd aws-upload-notifier
   ```
2. **Deploy modules in sequence**
   - Start with IAM, then S3, DynamoDB, and finally Lambda.

## Project Structure
```
.
├── environments
│   ├── dev
│   └── terragrunt.hcl
└── modules
    ├── dynamodb
    ├── iam
    ├── lambda
    ├── s3
    └── stepfunction
```

## Example:
```bash
cd environments/dev/iam 
# Initialize Terragrunt
terragrunt init

# Plan changes
terragrunt plan -out=plan-iam.tfplan

# Apply changes
terragrunt apply "plan-iam.tfplan"
```

After finishing deploying all the modules you can test the solution like this:

```bash
# Create test file
echo "Test content $(date)" > test.txt

# Upload to S3
aws s3 cp test.txt s3://YOUR_BUCKET_NAME/

# Watch Lambda logs
aws logs tail /aws/lambda/file-processor --follow

# Check DynamoDB records
aws dynamodb scan --table-name Files
```










## AWS CLI examples
### S3
```shell
aws --endpoint-url http://localhost:4566 s3 cp README.md s3://test-bucket/
```

## StepFunctions
```shell
aws --endpoint-url http://localhost:4566 stepfunctions list-state-machines
```

## DynamoDb

```shell
aws --endpoint-url http://localhost:4566 dynamodb scan --table-name Files
```
