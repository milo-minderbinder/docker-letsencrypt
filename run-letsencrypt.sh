#!/bin/bash

if [[ -z "${LE_DOMAIN}" ]]; then
	read -p "Site domain: " le_domain
	export LE_DOMAIN="${le_domain}"
fi
if [[ -z "${AWS_ACCESS_KEY_ID}" ]]; then
	read -p "AWS Access Key ID: " aws_ak_id
	export AWS_ACCESS_KEY_ID="${aws_ak_id}"
fi
if [[ -z "${AWS_SECRET_ACCESS_KEY}" ]]; then
	read -p "AWS Access Key Secret: " aws_ak_secret
	export AWS_SECRET_ACCESS_KEY="${aws_ak_secret}"
fi
if [[ -z "${LE_AWS_CF_DISTRIBUTION_ID}" ]]; then
	read -p "AWS CloudFront Distribution ID: " aws_cf_dist_id
	export LE_AWS_CF_DISTRIBUTION_ID="${aws_cf_dist_id}"
fi
if [[ -z "${LE_AWS_REGION}" ]]; then
	export LE_AWS_REGION="us-east-1"
fi

letsencrypt --agree-tos \
	-a letsencrypt-s3front:auth \
	--letsencrypt-s3front:auth-s3-bucket "${LE_DOMAIN}" \
	--letsencrypt-s3front:auth-s3-region "${LE_AWS_REGION}" \
	-i letsencrypt-s3front:installer \
	--letsencrypt-s3front:installer-cf-distribution-id "${LE_AWS_CF_DISTRIBUTION_ID}" \
	-d "${LE_DOMAIN}"

