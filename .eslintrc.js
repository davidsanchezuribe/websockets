module.exports = {
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
}
