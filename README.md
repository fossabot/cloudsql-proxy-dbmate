# securenomad/cloudsql-proxy-dbmate
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fsecurenomad%2Fcloudsql-proxy-dbmate.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fsecurenomad%2Fcloudsql-proxy-dbmate?ref=badge_shield)


An image that runs cloudsql-proxy and lets [amacneil/dbmate](https://github.com/amacneil/dbmate) connect to your SQL instance. This should be used with Google Cloud Build but may work on other build systems with appropriate access.

## How to use

Your Cloud Build Service Account (ending in `@cloudbuild.gserviceaccount.com`) will need the `Cloud SQL Client` and `Secret Manager Secret Accessor` roles.

Then create a these keys in Google Secret Manager.

```
mysql_connection_name
mysql_database
mysql_username
mysql_password
```

Last, use this image in any `cloudbuild.yaml` file with the dbmate command you want to run.

Ex:

```
- name: 'securenomad/cloudsql-proxy-dbmate'
  args: ['up']
  dir: database
```

## How it works

Secrets are accessed and used by `wrapper.bash`. This script starts `cloud_sql_proxy` and runs it in the background. A `DATABASE_URL` environment variable is generated for dbmate to use.


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fsecurenomad%2Fcloudsql-proxy-dbmate.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fsecurenomad%2Fcloudsql-proxy-dbmate?ref=badge_large)