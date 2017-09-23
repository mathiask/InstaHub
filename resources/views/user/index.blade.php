@extends('layouts.app')

@section('content')

    <div class="container">
        @include('flash::message')
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <ul class="list-group">
                    @foreach($users as $user)
                        <li class="list-group-item">
                            @if (Auth::user()->isfollowing($user))
                                <form style="float: right;" action="{{ route('follow', $user->id) }}" method="post">
                                        {{ csrf_field() }}
                                        <input type="hidden" name="_method" value="DELETE">
                                        <input type="submit" class="btn btn-danger" value="Unfollow" />
                                </form>
                            @elseif (Auth::user()->id != $user->id)
                                <form style="float: right;"action="{{ route('follow', $user->id) }}" method="post">
                                    {{ csrf_field() }}
                                    <input type="submit" class="btn btn-success" value="Follow" />
                                </form>
                            @endif
                            
                            <h4>
                                <img class="img-circle" src="/{{ $user->avatar }}" alt="{{ $user->avatar }}" height="50" width="50">
                                <a href ="{{'/user/' . $user->username}}">{{ $user->name }}</a>
                                <h5 style="display:inline">{{ '@' . $user->username }}</h5> &nbsp;
                                <p>
                                    <b>{{$user->photos()->count()}}</b> Photos. 
                                    <a href ="{{'/user/' . $user->username . '/followers'}}"><b>{{$user->followers->count()}}</b> Follower</a>.
                                    <a href ="{{'/user/' . $user->username . '/following'}}">Follows <b>{{$user->following->count()}}</b></a>.
                                </p>
                            </h4>

                        </li>
                    @endforeach
                </ul>
            </div>
        </div>
    </div>



@endsection