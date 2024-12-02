# aws-upload-notifier

This project sets up an automated workflow for tracking and monitoring file uploads in S3 buckets. 

> The main purpose of this project was to practice a litte bit of serverless architecture on AWS using terraform/terragrunt.

## Architecture

![Architecture](assignment.drawio.png)

We're going to track a list of files that have been uploaded. For this we're going to need:
- A S3 Bucket to where we upload files;
- A DynamoDb table called `Files` with an attribute `FileName`;
- A Stepfunction that writes to the DynamoDb table;
- A Lambda that get's triggered after a file upload and then executes the stepfunction.

### Prerequisites
- [AWS CLI](https://aws.amazon.com/cli/ )configured
- [Terraform v1.9.8](https://www.terraform.io/)
- [Terragrunt v0.69.1](https://terragrunt.gruntwork.io/)

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

Make sure you have all the necessary permissions to run the commands above. You can check the policies attached to your user like this:

```
aws iam list-attached-user-policies --user-name YOUR_USERNAME
```
