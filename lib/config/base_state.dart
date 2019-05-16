class BaseState {
    Function setState;
    
    BaseState(this.setState);

    updateState() {
        this.setState(() {});
    }
}