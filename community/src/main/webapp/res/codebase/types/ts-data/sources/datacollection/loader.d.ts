import { IDataChangeStack, IDataDriver, IDataProxy, IDataCollection, DataDriver } from "../types";
export declare class Loader {
    private _parent;
    private _saving;
    private _changes;
    constructor(parent: IDataCollection, changes: any);
    load(url: IDataProxy, driver?: IDataDriver | DataDriver): Promise<any>;
    parse(data: any | any[], driver?: IDataDriver | DataDriver): any;
    save(url: IDataProxy): void;
    updateChanges(changes: IDataChangeStack): void;
    private _setPromise;
    private _addToChain;
    private _findPrevState;
    private _removeFromOrder;
    private _getUniqueOrder;
}
