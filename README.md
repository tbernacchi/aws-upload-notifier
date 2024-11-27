# aws-engineering-terraform

This is a terraform project that provisions the architecture described in the following diagram.

> The main purpose of this project was to practice a litte bit of terraform/terragrunt on AWS.

## Architecture

![Architecture](assignment.drawio.png)

We're going to track a list of files that have been uploaded. For this we're going to need:
- A S3 Bucket to where we upload files;
- A DynamoDb table called `Files` with an attribute `FileName`;
- A Stepfunction that writes to the DynamoDb table;
- A Lambda that get's triggered after a file upload and then executes the stepfunction.

# Usage

## Start localstack (START HERE)

```shell
docker-compose up
```

Watch the logs for `Execution of "preload_services" took 986.95ms`

## Authentication
```shell
export AWS_ACCESS_KEY_ID=foobar
export AWS_SECRET_ACCESS_KEY=foobar
export AWS_REGION=eu-central-1
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
