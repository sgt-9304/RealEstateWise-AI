export function RedFlags({flags}:{flags:string[]}){return <article className="card"><h3 className="warn">Red flags and evidence gaps</h3><ul>{flags.map(x=><li key={x}>{x}</li>)}</ul></article>}
