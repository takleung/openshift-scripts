oc adm top nodes > oc_adm_top_nodes.txt

for project in $(oc get projects -o name)
do
    oc describe $project > project.${project#*/}.yaml
    oc adm top pods -n ${project#*/} > project.top.pods.${project#*/}.yaml
done

a='deployment;deploymentconfig;pod;quota;ClusterResourceQuota'
aa=$(echo $a | tr ";" "\n")
for enq in $aa
do
    for project in $(oc get projects -o name)
    do
        for object in $(oc get $enq -o name -n ${project#*/})
        do
            oc describe $object -n ${project#*/} > ${project#*/}.$enq.${object#*/}.yaml
        done
    done
done

for project in $(oc get projects -o name)
do
  for object in $(oc get deployment -o name -n ${project#*/})
  do
    oc describe $object -n ${project#*/} > ${project#*/}.deployment.${object#*/}.yaml
  done
done

for project in $(oc get projects -o name)
do
  for object in $(oc get deploymentconfig -o name -n ${project#*/})
  do
    oc describe $object -n ${project#*/} > ${project#*/}.deploymentconfig.${object#*/}.yaml
  done
done

for project in $(oc get projects -o name)
do
  for object in $(oc get pod -o name -n ${project#*/})
  do
    oc describe $object -n ${project#*/} > ${project#*/}.pod.${object#*/}.yaml
  done
done

for project in $(oc get projects -o name)
do
  for object in $(oc get quota -o name -n ${project#*/})
  do
    oc describe $object -n ${project#*/} > ${project#*/}.quota.${object#*/}.yaml
  done
done

for project in $(oc get projects -o name)
do
  for object in $(oc get ClusterResourceQuota -o name -n ${project#*/})
  do
    oc describe $object -n ${project#*/} > ${project#*/}.ClusterResourceQuota.${object#*/}.yaml
  done
done




