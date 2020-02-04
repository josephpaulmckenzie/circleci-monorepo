# /!/bin/bash 


# Build affected projects and their dependencies

projects_inc_dep=(`cat projects`)
echo -e "Calculating dependencies\n"
# Lists folders in current directory  
for dir in `ls -d */`; do
    for dep in `npm list ./${dir} 2>/dev/null`; do
    for project_dep in `echo $dep | grep github.com/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME | egrep -v "vendor|${dir%\/}"`; do
        if [[ " ${projects_inc_dep[@]} " =~ " ${project_dep##*\/} " ]] && ! [[ " ${projects_inc_dep[@]} " =~ " ${dir%\/} " ]]; then
        projects_inc_dep+=(${dir%\/})
        fi
    done
    done
done

echo -e "Building: ${projects_inc_dep[@]}\n"
for project in ${projects_inc_dep[@]}; do
    if grep -Fxq $project project-dirs; then
    printf "\nTriggering build for project: "$project
    curl -s -u ${CIRCLE_TOKEN}: \
        -d build_parameters[CIRCLE_JOB]=${project} \
        https://circleci.com/api/v1.1/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/tree/$CIRCLE_BRANCH
    fi
done