import * as elmPages from "./elm-pages-cli.mjs";
import * as busboy from "busboy";



export const handler = render;


/**
 * @param {import('aws-lambda').APIGatewayProxyEvent} event
 * @param {any} context
 */
async function render(event, context) {
  try {
    const renderResult = await elmPages.render(await reqToJson(event));
    const { headers, statusCode } = renderResult;

    if (renderResult.kind === "bytes") {
      return {
        body: Buffer.from(renderResult.body).toString("base64"),
        isBase64Encoded: true,
        multiValueHeaders: {
          "Content-Type": ["application/octet-stream"],
          "x-powered-by": ["elm-pages"],
          ...headers,
        },
        statusCode,
      };
    } else if (renderResult.kind === "api-response") {
      return {
        body: renderResult.body,
        multiValueHeaders: headers,
        statusCode,
        isBase64Encoded: renderResult.isBase64Encoded,
      };
    } else {
      return {
        body: renderResult.body,
        multiValueHeaders: {
          "Content-Type": ["text/html"],
          "x-powered-by": ["elm-pages"],
          ...headers,
        },
        statusCode,
      };
    }
  } catch (error) {
    console.error(error);
    console.error(JSON.stringify(error, null, 2));
    return {
      body: `<body><h1>Error</h1><pre>${JSON.stringify(error, null, 2)}</pre></body>`,
      statusCode: 500,
      multiValueHeaders: {
        "Content-Type": ["text/html"],
        "x-powered-by": ["elm-pages"],
      },
    };
  }
}

/**
 * @param {import('aws-lambda').APIGatewayProxyEvent} req
 * @returns {{method: string; rawUrl: string; body: string?; headers: Record<string, string>; multiPartFormData: unknown }}
 */
function reqToJson(req) {
  return {
    requestTime: Math.round(new Date().getTime()),
    method: req.httpMethod,
    headers: req.headers,
    rawUrl: req.rawUrl,
    body: req.body || null,
    multiPartFormData: null,
  };
}
