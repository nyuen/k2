module.exports = async function (context, req) {
    var admissionRequest = req.body;

    // Get a reference to the pod spec
    var object = admissionRequest.request.object;
  
    console.log(`validating the ${object.metadata.name} pod`);
  
    var admissionResponse = {
      allowed: false
    };
  
    var found = false;
    for (var container of object.spec.containers) {
      if ("env" in container) {
        console.log(`${container.name} is using env vars`);
  
        admissionResponse.status = {
          status: 'Failure',
          message: `${container.name} is using env vars`,
          reason: `${container.name} is using env vars`,
          code: 402
        };
  
        found = true;
      };
    };
  
    if (!found) {
      admissionResponse.allowed = true;
    }
  
    var admissionReview = {
      response: admissionResponse
    };
  
    context.res.setHeader('Content-Type', 'application/json');
    context.res.send(JSON.stringify(admissionReview));
    context.res.status(200).end();
  };