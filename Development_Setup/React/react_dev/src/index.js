import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';

class Board extends React.Component {
    render() {
        const status = 'Hello World!';
        return (
            <div>
                <div className="status">{status}</div>
            </div>
        );
    }
}


ReactDOM.render(
    <Board />,
    document.getElementById('root')
);
