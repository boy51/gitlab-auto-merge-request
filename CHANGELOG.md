# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

# 2.1.1 - 2021-04-13

### Changed

- improve dockerfile to be more predictable
  - now uses `ENTRYPOINT` running bash rather than `CMD`. This is because scripts were meant to run in bash.

# 2.1.0 - 2021-04-13

### Added

- `merge-request-post-deploy.sh`: script to run when your deploy is finished, opens merge request from master to develop. This is useful when using tools like `standard-version` to create changelog and bumping version on release branch targeting master. In this flow master has to be merged into develop to match versions on branches.

## 2.0.0 - 2021-09-04

### Changed

- Change target branch
  - Now targets develop or master branch depending on branch prefix
- Improve syntax
- Change default branch
  - No longer has to be fetched with curl, use environment variable ${CI_DEFAULT_BRANCH}

## 1.0.0 - 2017-09-10

### Added

- Add Dockerfile
- Add script from <https://rpadovani.com/open-mr-gitlab-ci>
- Add check if `$GITLAB_PRIVATE_TOKEN` is set
- Fail entire script on errors

### Changed

- Rename `$PRIVATE_TOKEN` to `$GITLAB_PRIVATE_TOKEN`
- Replace Python with [jq](https://stedolan.github.io/jq) to handle JSON
- Change `.gitlab-ci.yml`
  - Use Docker Image
  - Skip cloning git repository

[unreleased]: https://github.com/olivierlacan/keep-a-changelog/compare/master...develop
