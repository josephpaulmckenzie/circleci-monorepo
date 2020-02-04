# /!/bin/bash 


# Build affected projects and their dependencies

projects_inc_dep=(`cat projects`)
        echo -e "Building: ${projects_inc_dep[@]}\n"
        for project in ${projects_inc_dep[@]}; do
        if grep -Fxq $project project-dirs; then
            printf "\nTriggering build for project: "$project
            curl -s -u ${CIRCLE_TOKEN}: \
            -d build_parameters[CIRCLE_JOB]=${project} \
            https://circleci.com/api/v1.1/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/tree/$CIRCLE_BRANCH
        fi
        done