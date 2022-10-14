const {argv} = require('node:process');
const crypto = require('crypto');
const fs = require('fs');

const commander = require('commander');

// Setup cmd-line defaults
commander
  .version('1.0.0', '-v, --version')
  .usage('[OPTIONS]...')
  .option('-f, --file <value>', 'Path to filename to SHA sum')
  .option('-l, --loop <value>', 'number of loops to execute', '100')
  .parse(process.argv);

const options = commander.opts();

console.log(options.file)
if(!options.file) {
    console.log('Error: Specify filename as an argument to calculate SHA256');
    process.exit(0);
}

// Read the file into a buffer
const fileBuffer = fs.readFileSync(options.file);


// Loop through X benchmarks
for(i = 0; i < options.loop; i++) {

    const hashSum = crypto.createHash('sha256');
    hashSum.update(fileBuffer);

    const hex = hashSum.digest('hex');

    // Write the seq ID and hash for verification
    console.log("%d)\t%s", i, hex);

}
