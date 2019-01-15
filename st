#!/usr/bin/env python3

import os
import subprocess
import sys
import re

repos_dir = os.path.expanduser("~/repos/")

if __name__ == "__main__":
    repo_url = sys.argv[1]
    match = re.search(r"([^@]*)@([^:]*):([^/]*)/(.*)\.git", repo_url)
    host = match[2]
    user = match[3]
    repo_name = match[4]

    git_dir = os.path.join(repos_dir, host, user, repo_name)

    try:
        os.makedirs(git_dir, mode = 0o755)
    except FileExistsError:
        print(git_dir + " already exists")
        sys.exit(0)

    subprocess.run(["git", "clone", repo_url, git_dir], cwd = git_dir, check = True)
