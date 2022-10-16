[
  {
    kind: 'Endpoints',
    apiVersion: 'v1',
    metadata: {
      name: 'external-api',
    },
    subsets: [
      {
        addresses: [
          {
            ip: '10.128.0.21',
          },
        ],
        ports: [
          {
            port: 443,
          },
        ],
      },
    ],
  },
]