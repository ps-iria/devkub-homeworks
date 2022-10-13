local p = import '../params.libsonnet';
local params = p.components;

[
    {
        apiVersion: 'v1',
        kind: 'Deployment',
        metadata: {
            name: 'frontend',
            labels: {
                app: 'frontend',
            },
        },
        spec: {
            replicas: params.frontend.replicas,
            selector: {
                matchLabels: {
                    app: 'frontend',
                },
            },
            template: {
                metadata: {
                    labels: {
                        app: 'frontend',
                    },
                },
                spec: {
                    containers: [
                        {
                            name: 'frontend',
                            image: params.frontend.image,
                            volumeMounts: [
                                {
                                    name: 'pv',
                                    mountPath: params.volumeMounts.mountPath,
                                },
                            ],
                            ports: [
                                {
                                    containerPort: params.frontend.port,
                                },
                            ],
                            environment: [
                                {
                                    name: 'BASE_URL',
                                    value: params.frontend.BASE_URL
                                },
                            ],
                        },
                    ],
                    volumes: [
                            {
                                name: 'pv',
                                persistentVolumeClaim: params.pvc.claimName,
                            },
                        ],
                },
            },

        },
    },
]