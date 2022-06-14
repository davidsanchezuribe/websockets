# ---Variables globales---
APP_NAME="backend-nodejs"
APP_DESCRIPTION="Backend API Service"
APP_TITLE="Backend App"
SUBDIRECTORY="/test/"
PORT="5000"
ORIGIN="localhost:8000"

# ---Creacion del archivo de administracion de dependencias npm---
echo "{
  \"name\": \"${APP_NAME}\",
  \"version\": \"1.0.0\",
  \"description\": \"${APP_DESCRIPTION}\",
  \"main\": \"index.js\",  
  \"scripts\": {
    \"start\": \"nodemon\",
    \"build\": \"tsc\",
    \"prettier\": \"prettier --config .prettierrc.json --write src/**/*.ts\",
    \"test\": \"jest\"
  },
  \"husky\": {
    \"hooks\": {
      \"pre-commit\": \"pretty-quick --staged\"
    }
  },
  \"author\": \"\",
  \"license\": \"ISC\"
}
" > ./package.json

# ---Instalacion de dependencias---
# Typescript
npm install --save-dev typescript ts-node
# Express
npm install --save-dev @types/express @types/cors
npm install --save express cors body-parser
# Nodemon
npm install --save-dev nodemon
# Eslint
npm install --save-dev @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-airbnb-typescript
npm install --save-dev eslint-plugin-import eslint-plugin-promise 
# Prettier Husky
npm install --save-dev prettier husky pretty-quick
# Test
npm install --save-dev jest @types/jest ts-jest supertest @types/supertest

echo '{
  "compilerOptions": {
      "target": "es5",
      "module": "commonjs",
      "sourceMap": true,
      "outDir": "./dist",
      "rootDir": "./src",
      "strict": true,
      "noImplicitAny": true,
      "moduleResolution": "node",
      "baseUrl": "./src",
      "esModuleInterop": true,
      "skipLibCheck": true,
      "forceConsistentCasingInFileNames": true
  },
  "lib": ["es2015"],
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}' > ./tsconfig.json
echo '{
    "watch": ["src"],
    "ext": ".ts",
    "ignore": [],
    "exec": "ts-node ./src/index.ts"
}' > ./nodemon.json
mkdir src
echo "import app from './server/app';

app.listen(${PORT}, () => {
  // eslint-disable-next-line
  console.log('listen on port ${PORT}');
});" > ./src/index.ts
mkdir src/server
echo "// libreria que recibe los llamados REST de la api
import express from 'express';
// librería para permitir el accesso desde ${ORIGIN}
import cors from 'cors';
// libreria para detectar el formato json automáticamente
import bodyParser from 'body-parser';

import clientAPI from './clientAPI';

const app = express();
app.use(bodyParser.json());
app.use(cors({ origin: '${ORIGIN}' }));
app.use('/client', clientAPI);

export default app;" > ./src/server/app.ts
echo "import express, { Request, Response } from 'express';

const clientAPI = express.Router();

clientAPI.get('/test', (req: Request, res: Response) => {
  res.send('Hello World');
});

export default clientAPI;" > ./src/server/clientAPI.ts
echo 'module.exports = {
    "env": {
        "es2020": true,
        "node": true
    },
    "extends": [
        "airbnb-base",
        "airbnb-typescript/base"
    ],
    "parserOptions": {
        "project": "tsconfig.json",
        "tsconfigRootDir": __dirname,
        "ecmaVersion": 11,
        "sourceType": "module"
    },
    "plugins": [
        "@typescript-eslint",
        "promise",
        "import"
    ],
    "ignorePatterns": ["jest.config.js", ".eslintrc.js"],
    "rules": {}
}' > ./.eslintrc.js
echo '{
  "singleQuote": true,
  "arrowParens": "always",
  "printWidth": 120
}' > ./.prettierrc.json
echo "dist" > ./.prettierignore
echo "module.exports = {
    clearMocks: true,
    roots: ['<rootDir>/src'],
    testEnvironment: 'node',
    preset: 'ts-jest'
};" > ./jest.config.js
echo "# Dependency directories
node_modules/" > ./.gitignore
npm run start
