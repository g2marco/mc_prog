const { exec } = require('child_process');

exec( 'echo mixedsignal | sudo -S ./pic16fxxx_driver_test', (err, stdout, stderr) => {
    if (err) {
        console.log( err);
        console.log(`stderr: ${stderr}`);
        return;
    
    } else {
        console.log(`stdout: ${stdout}`);
    
    }
});
