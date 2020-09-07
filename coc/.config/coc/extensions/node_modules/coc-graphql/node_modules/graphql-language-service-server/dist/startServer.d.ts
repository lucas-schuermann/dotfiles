import { GraphQLConfig } from 'graphql-config';
import { parseDocument } from './parseDocument';
export declare type ServerOptions = {
    port?: number;
    method?: 'socket' | 'stream' | 'node';
    configDir?: string;
    extensions?: Array<(config: GraphQLConfig) => GraphQLConfig>;
    fileExtensions?: string[];
    config?: GraphQLConfig;
    parser?: typeof parseDocument;
};
export default function startServer(options: ServerOptions): Promise<void>;
//# sourceMappingURL=startServer.d.ts.map