# bash
This is for bash scripts to make easy server backup control.
The bash script is for managing servers a lot more easily and getting any notification from the server.
In Linux, everything is a file.
SED & AWK is very essential to control a file.

# Variable expanding

- Always good practice to use {} for variables like below

      ${var1}
# Scriptflow

# Converting File descriptors

To Convert a file descriptor from one type to another, add to the syntax an ampersand symbol on the right side of the greater than redirection symbol, followed by the File Descriptor number:

# Converting Stdout to Stderr
      echo "I'm turning this Standard Output echo into a Standard Error" >&2
# Converting Stderr to Stdout

      ls -j 2>&1


                  #!/bin/bash
                  
                  project=${1}
                  branch=${2}
                  
                  if [[ -z "${project}" ]]; then
                     echo "Error: Git project not specified"
                     exit 1
                  fi
                  
                  project_dir="$(basename "${project}" .git)"
                  
                  clone_project() {
                    if [[ ! -d "${project_dir}" ]]; then
                      git clone ${1}
                    fi
                  }
                  
                  find_files() {
                    find ${1} -type f | wc -l
                  }
                  
                  git_checkout() {
                    cd "${1}"
                    if [[ ! -z "${branch}" ]]; then
                      git checkout "${branch}" ||echo "Error: Branch ${branch} doesn't exist in ${project}."; exit 1
                    fi
                  }
                  
                  clone_project "${project}"
                  git_checkout "${project_dir}"
                  find_files "."


# To silence both Standard Output and Standard Error, the contents should be redirected to /dev/null. 

      /home/bob/script/fd-practice2.sh > /dev/null 2>&1
