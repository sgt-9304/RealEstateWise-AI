export function MetricPanel({name,value}:{name:string;value:string|number}){return <div className="card"><div className="muted">{name}</div><h3>{value}</h3></div>}
