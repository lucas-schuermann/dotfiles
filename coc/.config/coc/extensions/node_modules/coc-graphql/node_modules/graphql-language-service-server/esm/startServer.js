import * as net from 'net';
import { MessageProcessor } from './MessageProcessor';
import { createMessageConnection, IPCMessageReader, IPCMessageWriter, SocketMessageReader, SocketMessageWriter, StreamMessageReader, StreamMessageWriter, } from 'vscode-jsonrpc';
import { CompletionRequest, CompletionResolveRequest, DefinitionRequest, DidOpenTextDocumentNotification, DidSaveTextDocumentNotification, DidChangeTextDocumentNotification, DidCloseTextDocumentNotification, ExitNotification, HoverRequest, InitializeRequest, PublishDiagnosticsNotification, DidChangeWatchedFilesNotification, ShutdownRequest, DocumentSymbolRequest, } from 'vscode-languageserver';
import { Logger } from './Logger';
export default async function startServer(options) {
    const logger = new Logger();
    if (options && options.method) {
        let reader;
        let writer;
        switch (options.method) {
            case 'socket':
                if (!options.port) {
                    process.stderr.write('--port is required to establish socket connection.');
                    process.exit(1);
                }
                const port = options.port;
                const socket = net
                    .createServer(client => {
                    client.setEncoding('utf8');
                    reader = new SocketMessageReader(client);
                    writer = new SocketMessageWriter(client);
                    client.on('end', () => {
                        socket.close();
                        process.exit(0);
                    });
                    const serverWithHandlers = initializeHandlers({
                        reader,
                        writer,
                        logger,
                        options,
                    });
                    serverWithHandlers.listen();
                })
                    .listen(port);
                return;
            case 'stream':
                reader = new StreamMessageReader(process.stdin);
                writer = new StreamMessageWriter(process.stdout);
                break;
            case 'node':
            default:
                reader = new IPCMessageReader(process);
                writer = new IPCMessageWriter(process);
                break;
        }
        try {
            const serverWithHandlers = initializeHandlers({
                reader,
                writer,
                logger,
                options,
            });
            return serverWithHandlers.listen();
        }
        catch (err) {
            logger.error('There was a Graphql LSP handler exception:');
            logger.error(err);
        }
    }
}
function initializeHandlers({ reader, writer, logger, options = {}, }) {
    try {
        const connection = createMessageConnection(reader, writer, logger);
        addHandlers(connection, logger, options.configDir, (options === null || options === void 0 ? void 0 : options.extensions) || [], options.config, options.parser, options.fileExtensions);
        return connection;
    }
    catch (err) {
        logger.error('There was an error initializing the server connection');
        logger.error(err);
        process.exit(1);
    }
}
function addHandlers(connection, logger, configDir, extensions, config, parser, fileExtensions) {
    const messageProcessor = new MessageProcessor(logger, extensions, config, parser, fileExtensions);
    connection.onNotification(DidOpenTextDocumentNotification.type, async (params) => {
        const diagnostics = await messageProcessor.handleDidOpenOrSaveNotification(params);
        if (diagnostics) {
            connection.sendNotification(PublishDiagnosticsNotification.type, diagnostics);
        }
    });
    connection.onNotification(DidSaveTextDocumentNotification.type, async (params) => {
        const diagnostics = await messageProcessor.handleDidOpenOrSaveNotification(params);
        if (diagnostics) {
            connection.sendNotification(PublishDiagnosticsNotification.type, diagnostics);
        }
    });
    connection.onNotification(DidChangeTextDocumentNotification.type, async (params) => {
        const diagnostics = await messageProcessor.handleDidChangeNotification(params);
        if (diagnostics) {
            connection.sendNotification(PublishDiagnosticsNotification.type, diagnostics);
        }
    });
    connection.onNotification(DidCloseTextDocumentNotification.type, params => messageProcessor.handleDidCloseNotification(params));
    connection.onRequest(ShutdownRequest.type, () => messageProcessor.handleShutdownRequest());
    connection.onNotification(ExitNotification.type, () => messageProcessor.handleExitNotification());
    connection.onNotification('$/cancelRequest', () => ({}));
    connection.onRequest(InitializeRequest.type, (params, token) => messageProcessor.handleInitializeRequest(params, token, configDir));
    connection.onRequest(CompletionRequest.type, params => messageProcessor.handleCompletionRequest(params));
    connection.onRequest(CompletionResolveRequest.type, item => item);
    connection.onRequest(DefinitionRequest.type, params => messageProcessor.handleDefinitionRequest(params));
    connection.onRequest(HoverRequest.type, params => messageProcessor.handleHoverRequest(params));
    connection.onNotification(DidChangeWatchedFilesNotification.type, params => messageProcessor.handleWatchedFilesChangedNotification(params));
    connection.onRequest(DocumentSymbolRequest.type, params => messageProcessor.handleDocumentSymbolRequest(params));
}
//# sourceMappingURL=startServer.js.map