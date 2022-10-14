
// this file has the baseline default parameters
{
  components: {
    db: {
      image: 'postgres:13-alpine',
      replicas: 1,
      port: 5432,
      postgres_user: 'postgres',
      postgres_password: 'postgres',
      postgres_db: 'news',
    },
    backend:{
      image: 'psiria/backend',
      replicas: 1,
      port: 9000,
    },
    frontend: {
      image: 'psiria/frontend',
      BASE_URL: 'http://backend:9000',
      replicas: 1,
      port: 8000,
    },
    volumeMounts: {
      mountPath: '/static',
    },
    pvc: {
      claimName: 'pvc',
      storage: '2Gi',
    }
  },
}
