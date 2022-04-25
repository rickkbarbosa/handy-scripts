# EC2-objects Tagging

## A python-based script to tag all resources attached on EC2 with name


## Intro

In order to keep objects tagged and organized, this lambda could get the instance tags and replicate over the attached resources (ENI and EBS). This is already handled by AWS itself when you launch a new instance manually, but it could be not applied if other ways is used for create instances.

This lambda could be scheduled to seek non-tagged Network interfaces and Volumes and apply the same tag, to keep your infrastructure updated (and your project manager happy).


### How-To

- Ensure your EC2 the needed tags to add on EBS and ENIs
- Create an IAM Policy using the `iam_policy` file example. 
- Attach this policy on a new rule.
- Create a Lambda function based on python. Just do a copy-paste from `lambda.py`
- Don't forget to attach the previous IAM role to this new function.
- If you want to run this script periodically, create a schedule after deploy it.


### One-time script

- Use the script `ec2-objectstagging.py`. Same script, just export your AWS variables on environment.

``` 
export AWS_REGION="your-region"
export AWS_ACCESS_KEY="AAAAbbbcccCDDDD123456"
export AWS_ACCESS_SECRET_KEY="ab/123456AABBCCDDEE"
python3 ec2-objectstagging.py
```