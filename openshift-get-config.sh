printf -v cdate 'ocp-%(%Y%m%d%H%M%S)T\n' -1
mkdir -p $cdate
cd $cdate

list='deployment;deploymentconfig;pod;quota;ClusterResourceQuota'
clist=$(echo $list | tr ";" "\n")

oc adm top nodes > oc_adm_top_nodes.txt

for project in $(oc get projects -o name)
do
    oc describe $project > project.${project#*/}.yaml
    oc adm top pods -n ${project#*/} > project.top.pods.${project#*/}.yaml
done

for enq in $clist
do
    for project in $(oc get projects -o name)
    do
        for object in $(oc get $enq -o name -n ${project#*/})
        do
            oc describe $object -n ${project#*/} > ${project#*/}.$enq.${object#*/}.yaml
        done
    done
done