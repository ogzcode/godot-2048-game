import './App.css';
import React from 'react';
import filterEmoji from "./filterEmoji";
import EmojiResult from "./components/EmojiResult";
import Search from "./components/SearchEmoji";

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      emojiList: filterEmoji("", 20)
    }
    this.handleEmojiChange = this.handleEmojiChange.bind(this);
  }
  handleEmojiChange(value) {
    this.setState({ emojiList: filterEmoji(value, 20) });
  }
  render() {
    return (
      <div className='container'>
        <Search onTextChange={this.handleEmojiChange} />
        <EmojiResult emojies={this.state.emojiList} />
      </div>
    );
  }
}

export default App;
