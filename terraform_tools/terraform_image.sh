#!/bin/bash
### Create a visualization on terraform plan
### https://github.com/im2nguyen/rover
terraform plan -out=plan.out
terraform show -json plan.out > plan.json
docker run --rm -it -p 9000:9000 -v $(pwd)/plan.json:/src/plan.json im2nguyen/rover:latest -planJSONPath=plan.json
