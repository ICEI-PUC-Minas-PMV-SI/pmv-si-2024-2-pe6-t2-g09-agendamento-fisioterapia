namespace Domain
{
    public readonly struct ValueResult
    {
        public bool IsSuccess { get; }
        public string? ErrorMessage { get; }

        private ValueResult(bool isSuccess, string? errorMessage)
        {
            IsSuccess = isSuccess;
            ErrorMessage = errorMessage;
        }
        public static ValueResult Success()
        {
            return new ValueResult(true, null);
        }

        public static ValueResult Failure(string errorMessage)
        {
            return new ValueResult(false, errorMessage);
        }
    }

    public readonly struct ValueResult<T>
    {
        public bool IsSuccess { get; }
        public string? ErrorMessage { get; }
        public T? Value { get; }

        private ValueResult(T? value, bool isSuccess, string? errorMessage)
        {
            IsSuccess = isSuccess;
            ErrorMessage = errorMessage;
            Value = value;
        }

        public static ValueResult<T> Success(T? value)
        {
            return new ValueResult<T>(value, true, null);
        }

        public static ValueResult<T> Failure(string? errorMessage)
        {
            return new ValueResult<T>(default, false, errorMessage);
        }

        public static ValueResult<T> Failure(T? value, string? errorMessage)
        {
            return new ValueResult<T>(value, false, errorMessage);
        }
    }
}
