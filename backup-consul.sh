#!/bin/sh

set -e
set -x

backup_local_path=/tmp/consul-backup
backup_local_acls_path=/tmp/consul-backup-acls

consul-backinator backup -file "${backup_local_path}" -acls "${backup_local_acls_path}"


backup_s3_prefix="/consul-backup-$(date -u +"%Y-%m-%d_%H-%M-%S")"
backup_s3_path="${backup_s3_prefix}/consul-backup"
backup_s3_acls_path="${backup_s3_prefix}/consul-backup-acls"

gof3r put --endpoint s3-eu-west-1.amazonaws.com -b ${BUCKET_NAME} -p "${backup_local_path}" -k "${backup_s3_path}"
gof3r put --endpoint s3-eu-west-1.amazonaws.com -b ${BUCKET_NAME} -p "${backup_local_path}.sig" -k "${backup_s3_path}.sig"
gof3r put --endpoint s3-eu-west-1.amazonaws.com -b ${BUCKET_NAME} -p "${backup_local_acls_path}" -k "${backup_s3_acls_path}"
gof3r put --endpoint s3-eu-west-1.amazonaws.com -b ${BUCKET_NAME} -p "${backup_local_acls_path}.sig" -k "${backup_s3_acls_path}.sig"

