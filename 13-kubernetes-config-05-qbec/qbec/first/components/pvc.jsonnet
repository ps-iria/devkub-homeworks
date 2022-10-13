local p = import '../params.libsonnet';
local params = p.components;

[
    {
        kind: 'PersistentVolume',
        apiVersion: 'v1',
        metadata: {
            name: 'pv',
        },
        spec: {
            storageClassName: 'nfs',
            accessModes: [
                'ReadWriteMany',
            ],
            capacity: {
                storage: params.pvc.storage
            },
            hostPath: {
                path: 'data/pv'
            },
        },
    },
    {
        kind: 'PersistentVolumeClaim',
        apiVersion: 'v1',
        metadata: {
            name: params.pvc.claimName,
        },
        spec: {
            storageClassName: 'nfs',
            accessModes: [
                'ReadWriteMany',
            ],
            resources: {
                requests: {
                    storage: params.pvc.storage
                },
            },
        },
    },
]