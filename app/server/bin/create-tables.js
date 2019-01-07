const server = require('../server');

const create = async function create(dsName) {
    let tables = new Set();
    const ignoreModels = [];

    const ds = server.dataSources[dsName];

    if (!ds) {
        throw new Error(`The data source ${dsName} does not exist`);
    }

    // create a list of unique model names
    Object.keys(server.models).map((key) => {
        const model = server.models[key];
        const name = model.name.toLowerCase();
        if (!ignoreModels.includes(name)) {
            tables.add(model.name);
        }
    });

    // convert model names to array
    tables = Array.from(tables);

    try {
        await ds.autoupdate(tables);

        // eslint-disable-next-line no-console
        console.log('Tables [' + tables + '] created in ', ds.adapter.name);

        await ds.disconnect();
    } catch (err) {
        console.error(err);
    }

    return tables;
};

module.exports = {
    create,
};
