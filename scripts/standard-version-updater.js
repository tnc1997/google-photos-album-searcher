const { major, minor, patch } = require("semver");
const YAML = require("yaml");

module.exports.readVersion = function (contents) {
    return YAML.parseDocument(contents).get("version").split("+")[0];
}

module.exports.writeVersion = function (contents, version) {
    const document = YAML.parseDocument(contents);
    document.set("version", `${version}+${(major(version) * 10000) + (minor(version) * 100) + (patch(version))}`);
    return document.toString();
}
