# EC2-objects Tagging

## A python-based script to tag all resources attached on EC2 with name


## Intro

In order to keep objects tagged and organized, this lambda could get the instance Name tag and spread over the attached resources (ENI and EBS). This is already handled by AWS itself when you launch a new instance manually, but it could be not applied if other ways is used for create instances.

This lambda could be scheduled to seek non-tagged Network interfaces and Volumes and apply the same tag, to keep your infrastructure updated (and your project manager happy).


### How-To

- Ensure your EC2 has a tag "Name" at least.
- Create an IAM Policy using the `iam_policy` file example. 
- Attach this policy on a new rule.
- Create a Lambda function based on python. Just do a copy-paste from `lambda.py`
- Don't forget to attach the previous IAM role to this new function.
- If you want to run this script periodically, create a schedule after deploy it.