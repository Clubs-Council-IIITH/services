function version(r) {
    r.return(200, njs.version);
}

async function gallery_index(r) {
    r.headersOut['Content-Type'] = 'application/json';

    try {
        var files1 = await r.subrequest('/static/gallery/1/');
        var files2 = await r.subrequest('/static/gallery/2/');

        var status_codes = [200, 404];
        
        if (status_codes.includes(files1.status) && status_codes.includes(files2.status)) {
            var body1 = [];
            var body2 = [];
            if (files1.status == 200) body1 = JSON.parse(files1.responseText);
            if (files2.status == 200) body2 = JSON.parse(files2.responseText);
            var body = body1.concat(body2);
            var names = body.map(function (file) {
                return file.name;
            });

            body = JSON.stringify(names);

            r.return(200, body);
        } else {
            r.return(500, JSON.stringify({ error: "Subrequest failed", "files1": files1.status, "files2": files2.status }));
        }
    } catch (error) {
        r.return(500, JSON.stringify({ error: "Subrequest error: " + error.message }));
    }
}


export default { version, gallery_index };